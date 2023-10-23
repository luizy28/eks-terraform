/*variable "username" {
  type    = list(string)
  default = []
}

variable "eks_admins" {
  description = "List of users for the admin group."
  type        = list(string)
  default = []
}

variable "eks_developers" {
  description = "List of users for the developer group."
  type        = list(string)
  default = []
}*/


variable "developers" {
  type = list(string)
}

variable "admins" {
  type = list(string)
}

variable "env" {
  type    = list(any)
  default = ["Development", "Production"]
}

variable "tags" {
  type = map(string)
  default = {
    Env = "Production"
  }
}


