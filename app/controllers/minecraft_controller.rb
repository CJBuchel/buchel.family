class MinecraftController < ApplicationController
  def download_modpack_DDSS
    send_file(
      "#{Rails.root}/storage/minecraft/modpacks/DD_SS_PACK.zip",
      filename: "DD_SS_PACK.zip",
      type: "application/octet-stream"
    )
  end
  def download_resourcepack_DDSS
    send_file(
      "#{Rails.root}/storage/minecraft/resources/DD_SS_RES.zip",
      filename: "DD_SS_PACK.zip",
      type: "application/octet-stream"
    )
  end
end