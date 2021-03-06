module VagrantPlugins
  module SyncedFolderNFSGuest
    module HostBSD
      module Cap
        class UnmountNFS

          def self.nfs_unmount(environment, ui, folders)
            folders.each do |name, opts|
              ui.detail(I18n.t("vagrant.actions.vm.share_folders.mounting_entry",
                               guestpath: opts[:guestpath],
                               hostpath: opts[:hostpath]))

              unmount_options = opts.fetch(:unmount_options, []).join(" ")

              umount_msg = `umount #{unmount_options} '#{opts[:hostpath]}' 2>&1`

              if $?.exitstatus != 0
                if not umount_msg.include? 'not currently mounted'
                  ui.info "NFS mounts still in use!"
                  exit(1)
                end
              end
            end
          end

        end
      end
    end
  end
end
