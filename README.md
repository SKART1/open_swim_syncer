
# About this Repository

This repository contains scripts that enable you to use the OpenSwim (formerly Xtrainerz) device as an audiobook or podcast player. The scripts allow you to split files into smaller parts, making it easier to select a playback position. They also facilitate copying files to the device while preserving their creation date order, ensuring correct playback sequence on OpenSwim (which orders files by creation date, not by name).

## Algorithm

1. Preprocess and split the initial MP3 file into parts using `preprocess_and_split.sh`.
2. Copy files to the device while preserving the creation date order using `copy_preserving_order.sh`.
3. Verify the order of the files on the device using `helper_show_creation_date.sh`.

## Prerequisites

- `sox` program package
- Bash interpreter

## Usage

### Increasing volume, normalizing, and splitting

After downloading an MP3 podcast episode, place it in a directory, for example, `6_03/6_03.mp3`. Run the following command:

```bash
./preprocess_and_split.sh 6_03/6_03.mp3 120
```

Here, the second argument (`120`) represents the desired length of each part in seconds.

After execution, you will get two files: `6_03_150.mp3` and `6_03_150_norm.mp3`. The first file has its volume increased by 50%, while the second is both increased by 50% and normalized. The `6_03/split` folder will contain the normalized file split into smaller parts.

### Copying while preserving order

To copy the split files to the device while preserving their creation date order, use:

```bash
./copy_preserving_order.sh 6_03/split/ /media/OpenSwim/6_03/
```

### Verifying file order

To view and validate the order of the files, run:

```bash
./helper_show_creation_date.sh /media/OpenSwim/6_03/
```
