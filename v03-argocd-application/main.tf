terraform {
  required_providers {
    argocd = {
      source  = "oboukili/argocd"
      version = "6.0.0"
    }
  }
}

provider "argocd" {
  server_addr = "192.168.174.192:32073"
  username    = "admin"
  password    = "ST43gN8qKIKsFEjI"
  insecure    = true
}

resource "argocd_application" "helm" {
  metadata {
    name      = "helm-app-using-terraform"
    namespace = "argocd"
    labels = {
      test = "true"
    }
  }

  spec {
    destination {
      server    = "https://kubernetes.default.svc"
      namespace = "terraform"
    }

    source {
      repo_url        = "https://github.com/emiakia/argocd.git"
      path            = "helm/nginx"
      target_revision = "main"
      helm {
        value_files = ["customValues.yaml"]
      }
    }
  }
}

