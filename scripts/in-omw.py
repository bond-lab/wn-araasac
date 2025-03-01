from langcodes import *

omwlangs = ["sq", "arb", "bg", "ca", "cmn-Hans", "da", "el", "eu", "fi", "fr", "gl", "he", "hr", "id", "it", "is", "it", "lt", "ja", "nl", "nn", "nb", "pl", "pt", "ro", "sk", "sl", "es", "sv", "th", "zsm", "en", "en", "fa", "cmn-Hant" ]

# harmonize
omwlangs.append('zh')
omwlangs.append('ar')
omwlangs.remove('cmn-Hans')
omwlangs.remove('arb')

aralangs = "an ar bg br ca cs da de el en es et eu fa fr gl he hr hu it ko lt lv mk nb nl pl pt ro ru sk sq sv sr val uk zh".split()

### no translations
aralangs.remove('sv')
aralangs.remove('sq')
### almost no translations
aralangs.remove('da')
aralangs.remove('lv')
aralangs.remove('el')
aralangs.remove('uk')

aralangs.append('ca-valencia')
aralangs.remove('val')
aralangs.append('pt-BR')
aralangs.remove('br')

tuflangs= "ar as de en es fr id ja km ko lo mn ms my pb pt ru th tl tr ur vi zh".split() 
tuflangs.append('zsm')
tuflangs.remove('ms')
tuflangs.append('pt-BR')
tuflangs.remove('pb')


print('# Comparing language coverage in OMW, TUFS and ARASAAC') 
print()
print("in TUFS:", tuflangs)
print("in ARA:", aralangs)


print("in OMW not ARA:", [l for l in omwlangs if l not in aralangs])
print("in ARA and OMW:", [l for l in omwlangs if l in aralangs])
print("in ARA not OMW:", [l for l in aralangs if l not in omwlangs])
print()

for l in [l for l in aralangs if l not in omwlangs]:
    print(l,  Language.get(l).display_name(), sep= '\t')
print()
    
print("in OMW not TUFS:", [l for l in omwlangs if l not in tuflangs])
print("in TUFS and OMW:", [l for l in omwlangs if l in tuflangs])
print("in TUFS not OMW:", [l for l in tuflangs if l not in omwlangs])
print()

for l in [l for l in tuflangs if l not in omwlangs]:
    print(l,  Language.get(l).display_name(), sep= '\t')

print("in TUFS not ARA:", [l for l in tuflangs if l not in aralangs])
print("in ARA and TUFS:", [l for l in tuflangs if l in aralangs])
print("in ARA not TUFS:", [l for l in aralangs if l not in tuflangs])
print()


for l in [l for l in aralangs if l not in tuflangs]:
    print(l,  Language.get(l).display_name(), sep= '\t')

print("in ARA or TUF not OMW:", [l for l in tuflangs + aralangs if l not in omwlangs])
