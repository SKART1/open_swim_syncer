# About this repo

This repo contains scripts which allows you to use OpenSwim (formely Xtrainerz) device as and audiobook/podcast player (you should download audiobook or podcast mp3 by your own)

# Algorythm
1. Preprocess and split initial mp3 in parts by `preprocess_and_split.sh`
2. Copy data to device preserving creation date order `copy_preserving_order.sh`
3. Check if order is correct by `helper_show_creation_date.sh`



