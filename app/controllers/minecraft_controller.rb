class MinecraftController < ApplicationController
  def download_modpack_DDSS
    send_file(
      "#{Rails.root}/storage/minecraft/modpacks/DD_SS_PACK.zip",
      filename: "DDSS_PACK.zip",
      type: "application/octet-stream"
    )
  end
  def download_resourcepack_DDSS
    send_file(
      "#{Rails.root}/storage/minecraft/resources/DD_SS_RES.zip",
      filename: "DDSS_RES.zip",
      type: "application/octet-stream"
    )
  end
  def download_forge_DDSS
    send_file(
      "#{Rails.root}/storage/minecraft/forge/forge-1.12.2-14.23.5.2854-installer.jar",
      filename: "DDSS_FORGE.jar",
      type: "application/octet-stream"
    )
  end
end