terraform {
    backend "s3" {
        key = "terraform/tfstate.tfstate"
        bucket = "fgsfds-terra-remote1"
        region = "eu-central-1"
        access_key = "AKIAURLOCCNS7IOK5SHM"
        secret_key = "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"
    }
}

