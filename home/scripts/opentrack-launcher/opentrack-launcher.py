# Forked from https://github.com/markx86/opentrack-launcher
from os.path import join, isfile, isdir, abspath
from os import makedirs, mkdir, environ, remove
from sys import argv
from urllib.request import urlopen, urlretrieve
from urllib.error import URLError
from shutil import which, rmtree
from subprocess import Popen
import json

def panic(msg):
    print("[opentrack-launcher] CRITICAL:", msg)
    exit(-1)

def error(msg):
    print("[opentrack-launcher] ERROR:", msg)

def info(msg):
    print("[opentrack-launcher] INFO:", msg)

def getenv(name):
    try:
        return environ[name]
    except KeyError:
        panic("environment variable", name, "not found")

APPIDSIG = "AppId="
APPHOME = getenv("HOME") if not isfile("/.flatpak-info") else join(getenv("HOME"), ".var/app/com.valvesoftware.Steam")
LAUNCHERHOME = join(APPHOME, ".local/share/opentrack-launcher")
OPENTRACKURL = "http://api.github.com/repos/opentrack/opentrack/releases/latest"
ZIPBINARY = ""

def findappid():
    appid = ""
    for arg in argv:
        if APPIDSIG in arg:
            appid = arg[len(APPIDSIG):]
    if appid == "":
        error("appid not found, falling back to executable name")
        appid = argv[-1]
        if not appid.endswith(".exe"):
            panic("could not find a valid Windows executable name")
    info("launching app with id " + str(appid) + "...")
    return appid

def isnewer(ver):
    versionfile = join(LAUNCHERHOME, "version.txt")
    if not isfile(versionfile):
        with open(versionfile, mode="w") as f:
            f.write(ver)
        f.close()
        return True
    with open(versionfile, mode="r+") as f:
        fver = f.read()
        newer = fver != ver
        if newer:
            f.truncate(0)
            f.write(ver)
        f.close()
        return newer

def removeversionfile():
    versionfile = join(LAUNCHERHOME, "version.txt")
    if isfile(versionfile):
        remove(versionfile)

def dlopentrack():
    info("checking if opentrack is up to date...")
    try:
        content = urlopen(OPENTRACKURL).read().decode("UTF-8")
    except URLError:
        error(msg)("could not get opentrack release manifest; error: " + str(e.reason))
        return
    
    try:
        latest = json.loads(content)
    except json.JSONDecodeError as e:
        error("could not parse opentrack release manifest; error occurred at line " + str(e.lineno) + ": " + str(e.msg))
        return
    version = latest["tag_name"].split("-")[1]
    if isnewer(version):
        info("downloading the latest opentrack version...")
        for asset in latest["assets"]:
            if asset["name"].endswith("portable.7z"):
                opentrackark = join(LAUNCHERHOME, "opentrack.7z")
                try:
                    urlretrieve(asset["browser_download_url"], opentrackark)
                except URLError as e:
                    error("failed to download opentrack; error: " + str(e.reason))
                    return
                if not isfile(opentrackark):
                    error("file " + opentrackark + " does not exist")
                    return
                opentrackinstall = join(LAUNCHERHOME, "install")
                if isdir(opentrackinstall):
                    info("removing old opentrack version...")
                    rmtree(opentrackinstall)
                info("extracting downloaded opentrack archive...")
                try:
                    err = Popen([ which(ZIPBINARY), "x", "-aoa", "-o" + LAUNCHERHOME, opentrackark ], cwd=LAUNCHERHOME).wait()
                    remove(opentrackark)
                    if err != 0:
                        panic("failed to extract " + opentrackark + "; 7z exit code: " + str(err))
                except:
                    # avoid unzip failure leaving files in a state where the launcher will never work again
                    removeversionfile()
                    remove(opentrackark)
                    raise
                return

def getopentrack():
    dlopentrack()
    opentrackexec = join(LAUNCHERHOME, "install/opentrack.exe")
    if not isfile(opentrackexec):
        removeversionfile()	# force next call of launcher to try to downloading OpenTrack again
        panic("could not find " + opentrackexec)
    else:
        return opentrackexec

def towinepath(p):
    p = abspath(p)
    p = p.replace("/", "\\")
    return "Z:" + p

def findappcmdline():
    cmdline = ""
    for arg in reversed(argv):
        cmdline = arg + " " + cmdline
        if arg.endswith(".exe"):
            break
    return cmdline.strip()

def getlaunchscript(appid, opentrackexec):
    scripts = join(LAUNCHERHOME, "scripts")
    if not isdir(scripts):
        mkdir(scripts)
        if not isdir(scripts):
            panic("failed to create scripts directory: " + scripts)
    script = join(scripts, appid + ".bat")
    if not isfile(script):
        info("generating script for app with id " + str(appid) + "...")
        appcmdline = findappcmdline()
        appsplitindex = appcmdline.index(".exe")+len(".exe")
        appexec = appcmdline[:appsplitindex]
        appargs = appcmdline[appsplitindex:]
        appwine = towinepath(appexec)
        opentrackwine = towinepath(opentrackexec)
        with open(script, mode="w") as f:
            f.writelines([
                "start \"\" \"" + appwine + "\"" + appargs + "\r\n",
                "start \"\" \"" + opentrackwine + "\"\r\n"
            ])
            f.close()
    return script

def makehome():
    if not isdir(LAUNCHERHOME):
        info("creating home...")
        makedirs(LAUNCHERHOME, exist_ok=True)
        if not isdir(LAUNCHERHOME):
            panic("failed to create opentrack-launcher home: " + LAUNCHERHOME)

def check7z():
    global ZIPBINARY
    if not which("7z") is None:
        ZIPBINARY = "7z"
    elif not which("7za") is None:
        ZIPBINARY = "7za"
        
    if not ZIPBINARY:
        panic("7z is not installed")

if __name__ == '__main__':
    check7z()
    makehome()
    appid = findappid()
    opentrackexec = getopentrack()
    launcherscript = getlaunchscript(appid, opentrackexec)
    for _ in range(len(argv), 0, -1):
        arg = argv.pop()
        if arg.endswith(".exe"):
            argv.append(launcherscript)
            break
    Popen(argv[1:]).wait()
    info("exiting...")
