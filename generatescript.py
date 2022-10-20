import os
import sys
import pathlib

(_,filepath,arch,version)=sys.argv
xarch={"x86":"x86", "x64":"amd64"}[arch]

filelist=""
deletelist=""
for filePath in pathlib.Path(f"OpenUtau-win-{arch}").iterdir():
    fileName=filePath.name
    filelist+=f'  File "{filePath}"\n'
    deletelist+=f'  Delete "$INSTDIR\\{fileName}"\n'

class Default(dict):
    def __missing__(self, key):
        return "{"+key+"}"

with open(os.path.join(filepath,"template.nsi"),"r",encoding="utf8") as inputfile:
    outputstr=inputfile.read().format_map(
        Default(
            arch=arch,
            version=version,
            xarch=xarch,
            filelist=filelist,
            deletelist=deletelist
        )
    )

with open(os.path.join(filepath,arch+".nsi"),"w",encoding="utf8") as outputfile:
    outputfile.write(outputstr)
