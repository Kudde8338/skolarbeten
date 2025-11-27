import requests
import zipfile
import os
import shutil

def download_source():
    url = "https://api.github.com/repos/prusa3d/PrusaSlicer/releases/latest"
    resp = requests.get(url)
    resp.raise_for_status()

    data = resp.json()

    for asset in data['assets']:
        if asset['name'].endswith('.zip'):
            asset_name = asset['name']
            download_url = asset['browser_download_url']
            print("Found zip:", asset['name'])
            print("URL:", download_url)
            break

    r = requests.get(download_url)
    with open(asset['name'], 'wb') as f:
        f.write(r.content)
        print("Source downloaded")

    return str(asset_name)






