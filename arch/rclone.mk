# Declare phony targets
.PHONY: rclone

# Declare directories
SYNC_SRC_DIR := /home/phantomwise/Sync/SynologyDrive

# Sync with rclone
rclone:
	@echo -e "\033[1;33mSyncing\033[0m"
	rclone sync $(SYNC_SRC_DIR) NAS:personal/Sync/Dell-Precision-7530-Arch-Rclone

