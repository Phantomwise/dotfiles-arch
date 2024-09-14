#!/usr/bin/env python3

import libtorrent as lt
import time
import os

def download_torrent_from_magnet(magnet_link, save_path):
    ses = lt.session()
    params = {
        'save_path': save_path,
        'storage_mode': lt.storage_mode_t.storage_mode_sparse,
    }
    handle = lt.add_magnet_uri(ses, magnet_link, params)
    ses.start_dht()

    print(f'Downloading Metadata for {magnet_link} (this may take a while)...')
    while not handle.has_metadata():
        print('.', end='', flush=True)
        time.sleep(1)
    print('\nMetadata Downloaded, Starting Torrent Download...')

    torrent_info = handle.get_torrent_info()
    torrent_file = lt.create_torrent(torrent_info)
    torrent_path = f"{save_path}/{torrent_info.name()}.torrent"
    with open(torrent_path, "wb") as f:
        f.write(lt.bencode(torrent_file.generate()))
    
    print(f'\033[92m[SUCCESS] Torrent file saved at: {torrent_path}\033[0m')

def download_torrents_from_file(file_path, save_path):
    with open(file_path, 'r') as file:
        magnet_links = [line.strip() for line in file.readlines()]
    
    for magnet_link in magnet_links:
        if magnet_link:
            print(f"Processing magnet link: {magnet_link}")
            download_torrent_from_magnet(magnet_link, save_path)

# Example usage
script_dir = os.path.dirname(os.path.abspath(__file__))
file_path = os.path.join(script_dir, "torrent-magnet-links.txt")
save_path = os.path.expanduser("~/Downloads")
print(f"Reading magnet links from: {file_path}")
print(f"Saving torrents to: {save_path}")
download_torrents_from_file(file_path, save_path)