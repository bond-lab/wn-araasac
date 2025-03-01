import os
import sys
import json
from collections import defaultdict as dd
import wn

# Ensure wordnets are downloaded
wn.download('omw-en31:1.4')
wn3 = wn.Wordnet(lexicon='omw-en:1.4')
wn31 = wn.Wordnet(lexicon='omw-en31:1.4')


def wn31to30(synset):
    """Convert WordNet 3.1 synset to 3.0"""
    try:
        ili = wn31.synset(f'omw-en31-{synset}').ili.id
        return wn3.synsets(ili=ili)[0]
    except:
        return None


def ara2wn(lang, input_dir, output_dir):
    """Convert ARASAAC JSON to OMW 1.0 format"""
    
    input_file = os.path.join(input_dir, f'{lang}.json')
    output_file = os.path.join(output_dir, f'{lang}-ara-wn.tab')

    if not os.path.exists(input_file):
        print(f"Warning: JSON file for '{lang}' not found in {input_dir}. Skipping.")
        return

    with open(input_file, 'r', encoding='utf-8') as f:
        data = json.load(f)

    os.makedirs(output_dir, exist_ok=True)

    with open(output_file, 'w', encoding='utf-8') as out:
        print(f"# Arasaac {lang}\t{lang}\turl\tCC BY-NC-SA", file=out)

        arawn = dd(set)
        araim = dd(set)

        for entry in data:
            for k in entry.get('keywords', []):
                lemma = k['keyword']
                if lemma and '\n' in lemma:
                    lemma = lemma.replace('\n', '')
                    print (f"Newline found in entry: {entry['_id']}: {k['keyword']}")
                if not lemma:
                    continue
                if (ss := entry.get('synsets')):
                    for s in ss:
                        wn30 = wn31to30(s)
                        if wn30:
                            arawn[wn30.id].add(lemma)
                            araim[wn30.id].add(entry['_id'])

        for ss in arawn:
            print(ss[7:], f'{lang}:def', 0, ' '.join(str(s) for s in araim[ss]), sep='\t', file=out)
            for lemma in arawn[ss]:
                if lemma:
                    print(ss[7:], f'{lang}:lemma', lemma, sep='\t', file=out)


if __name__ == "__main__":
    if len(sys.argv) != 4:
        print("Usage: python ara2tab.py <input_dir> <output_dir> '<lang1 lang2 lang3 ...>'")
        sys.exit(1)

    input_dir = sys.argv[1]
    output_dir = sys.argv[2]
    languages = sys.argv[3].split()

    for lang in languages:
        print(f"Converting to tab: {lang}")
        ara2wn(lang, input_dir, output_dir)
