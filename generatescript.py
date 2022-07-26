import os
import sys
(_,filepath,arch,version)=sys.argv
with open(os.path.join(filepath,"template.nsi"),"r",encoding="utf8") as inputfile:
    outputstr=inputfile.read().replace("{arch}",arch).replace("{version}",version)
with open(os.path.join(filepath,arch+".nsi"),"w",encoding="utf8") as outputfile:
    outputfile.write(outputstr)