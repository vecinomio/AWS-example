# Configure AWS provider
provider "aws" {
  region = "eu-central-1"
}

# Configure The GCP provider
provider "google" {
  credentials = "${file("../account.json")}"
  project     = "terraform-trainee"
  region      = "europe-west3-c"
}
