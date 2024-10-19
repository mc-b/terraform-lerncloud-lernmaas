###
#   Provider 
#

provider "maas" {
  # Configuration options
  api_version = "2.0"
  api_key     = var.key
  api_url     = var.url
}