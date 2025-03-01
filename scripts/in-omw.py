from langcodes import *

omwlangs = ["sq", "arb", "bg", "ca", "cmn-Hans", "da", "el", "eu", "fi", "fr", "gl", "he", "hr", "id", "it", "is", "it", "lt", "ja", "nl", "nn", "nb", "pl", "pt", "ro", "sk", "sl", "es", "sv", "th", "zsm", "en", "en", "fa", "cmn-Hant"]

# Harmonize OMW languages
omwlangs.append('zh')
omwlangs.append('ar')
omwlangs.remove('cmn-Hans')
omwlangs.remove('arb')

aralangs = "an ar bg br ca cs da de el en es et eu fa fr gl he hr hu it ko lt lv mk nb nl pl pt ro ru sk sq sv sr val uk zh".split()

# Remove languages with no or minimal translations
aralangs.remove('sv')
aralangs.remove('sq')
aralangs.remove('da')
aralangs.remove('lv')
aralangs.remove('el')
aralangs.remove('uk')

# Fix variations
aralangs.append('ca-valencia')
aralangs.remove('val')
aralangs.append('pt-BR')
aralangs.remove('br')

tuflangs = "ar as de en es fr id ja km ko lo mn ms my pb pt ru th tl tr ur vi zh".split()
tuflangs.append('zsm')
tuflangs.remove('ms')
tuflangs.append('pt-BR')
tuflangs.remove('pb')

# Start Markdown output
print("# Comparing Language Coverage in OMW, TUFS, and ARASAAC\n")

print("## Summary\n")
print("- **Languages in TUFS:**", len(tuflangs))
print("- **Languages in ARASAAC:**", len(aralangs))
print("- **Languages in OMW:**", len(omwlangs), "\n")

# Function to print a Markdown table
def print_table(header, data):
    print(f"## {header}\n")
    print("| Code | Language |")
    print("|------|----------|")
    for l in data:
        print(f"| {l} | {Language.get(l).display_name()} |")
    print("\n")

# Differences between OMW and ARASAAC
print_table("Languages in OMW but not in ARASAAC", [l for l in omwlangs if l not in aralangs])
print_table("Languages in both OMW and ARASAAC", [l for l in omwlangs if l in aralangs])
print_table("Languages in ARASAAC but not in OMW", [l for l in aralangs if l not in omwlangs])

# Differences between OMW and TUFS
print_table("Languages in OMW but not in TUFS", [l for l in omwlangs if l not in tuflangs])
print_table("Languages in both OMW and TUFS", [l for l in omwlangs if l in tuflangs])
print_table("Languages in TUFS but not in OMW", [l for l in tuflangs if l not in omwlangs])

# Differences between ARASAAC and TUFS
print_table("Languages in TUFS but not in ARASAAC", [l for l in tuflangs if l not in aralangs])
print_table("Languages in both ARASAAC and TUFS", [l for l in tuflangs if l in aralangs])
print_table("Languages in ARASAAC but not in TUFS", [l for l in aralangs if l not in tuflangs])

# Final comparison: Languages in either TUFS or ARASAAC but not in OMW
print_table("Languages in ARASAAC or TUFS but not in OMW", [l for l in tuflangs + aralangs if l not in omwlangs])
