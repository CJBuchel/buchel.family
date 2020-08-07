class MinecraftController < ApplicationController
  def download_modpack_ScienceBallz
    send_file(
      "#{Rails.root}/storage/minecraft/modpacks/ScienceBallz.zip",
      filename: "ScienceBallz.zip",
      type: "application/octet-stream"
    )
  end
  def download_resourcepack_ScienceBallz
    send_file(
      "#{Rails.root}/storage/minecraft/resources/ScienceBallz_Res.zip",
      filename: "ScienceBallz_Res.zip",
      type: "application/octet-stream"
    )
  end
  def download_forge_1_12_2
    send_file(
      "#{Rails.root}/storage/minecraft/forge/forge-1.12.2-14.23.5.2854-installer.jar",
      filename: "forge_1-12-2.jar",
      type: "application/octet-stream"
    )
  end
end