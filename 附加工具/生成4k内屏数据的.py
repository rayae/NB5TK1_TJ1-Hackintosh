# Get and modify laptop 4k display edid for big sur
# Created by xxxzc
# Reference: http://bbs.pcbeta.com/forum.php?mod=viewthread&tid=1866466&highlight=edid
from subprocess import check_output
from base64 import b64encode
edid = check_output('ioreg -lw0 | grep -i "IODisplayEDID"',
                    shell=True, encoding='utf-8')
edid = edid.split('<')[1].split('>')[0]
print('Display EDID:', edid)
edid = edid[:108] + 'a6a6' + edid[112:] # set refresh rate to 48Hz
data = [int(edid[i:i+2], 16) for i in range(0, len(edid), 2)]
checksum = hex(256 - sum(data[:-1]) % 256)[2:]
print('Modified EDID:', edid[:-2] + checksum)
data[-1] = int(checksum, 16)
print('data:', b64encode(bytes(data)).decode('utf-8'))
print('you need to add data to PciRoot(0x0)/Pci(0x2,0x0)>AAPL00,override-no-connect')