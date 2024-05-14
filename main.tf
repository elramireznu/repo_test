# Configure the required providers, in this case, GitHub
terraform {
  required_providers {
    github = {
      source  = "integrations/github"
      version = "~> 5.0"
    }
  }
}


provider "github" {
  token = "ghp_*************************************"
  owner = "lab-tf-at"
}

# Create a GitHub membership resource for a specific user
resource "github_membership" "membership_for_user_x" {
  username = "elramirezn"
  role     = "member"

}

# Define a repository for Terraform lab codebase with initial commit
resource "github_repository" "labo-terraform-codebase" {
  name               = "labo-terraform-codebase"
  description        = "My awesome codebase"
  visibility         = "public"
  auto_init          = true
  allow_update_branch = true
}

# Define a repository for Terraform lab webpage with GitHub Pages enabled
resource "github_repository" "labo-terraform-webpage" {
  name        = "labo-terraform-webpage"
  description = "My awesome webpage"
  visibility  = "public"
  auto_init   = true

  pages {
    source {
      branch = "main"
      path   = "/docs"
    }
  }
}

# Create multiple branches for the codebase repository
resource "github_branch" "development_branch_codebase" {
  repository = github_repository.labo-terraform-codebase.name
  branch     = "dev"
  depends_on = [github_repository.labo-terraform-codebase]
}

resource "github_branch" "feature_branch_codebase" {
  repository = github_repository.labo-terraform-codebase.name
  branch     = "release"
  depends_on = [github_repository.labo-terraform-codebase]
}

resource "github_branch" "release_branch_codebase" {
  repository = github_repository.labo-terraform-codebase.name
  branch     = "fixes"
  depends_on = [github_repository.labo-terraform-codebase]
}

# Create multiple branches for the webpage repository
resource "github_branch" "development_branch_webpage" {
  repository = github_repository.labo-terraform-webpage.name
  branch     = "dev"
  depends_on = [github_repository.labo-terraform-webpage]
}

resource "github_branch" "feature_branch_webpage" {
  repository = github_repository.labo-terraform-webpage.name
  branch     = "release"
  depends_on = [github_repository.labo-terraform-webpage]
}

resource "github_branch" "release_branch_webpage" {
  repository = github_repository.labo-terraform-webpage.name
  branch     = "fixes"
  depends_on = [github_repository.labo-terraform-webpage]
}
