variable "username" {
  type    = list(any)
  default = ["paul", "mark", "ade", "slim"]
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

variable "groups" {
  type    = list(string)
  default = ["admin", "developers"]
}



