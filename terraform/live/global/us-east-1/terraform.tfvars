# ---------------------------------------------------------------------------------------------------------------------
# - GLOBAL VARIABLES -
# ---------------------------------------------------------------------------------------------------------------------

aws                         = {
  region                    = "us-east-1"
  namespace                 = "live"
  alias                     = "lv"
  id                        = ""
  account                   = ""
  availability_zones        = "us-east-1a,us-east-1c,us-east-1d"   #availability_zone = "${element(split(",", lookup(var.azones, var.region.primary)), count.index%2)}"
}

default_tags          = {
  "Application"       = "MEAN"
  "Code"              = "1234"
}

#TODO: provide an option to retrieve dynamically
amis = {
  "us-east-1-web-mar-18"      = "ami-2051294a"
}

instance_types = {
  "web"  = "t2.micro"
  "app"  = "t2.micro"
  "data" = "t2.micro"
  "nat"  = "t2.micro"
}

regions = {
  "primary" = "us-east-1"
  "backup" = "us-west-2"
}

available_user_data ={
  "web"    = "web_user_data.txt"
  "app"    = "app_user_data.txt"
  "data"   = "data_user_data.txt"
}
