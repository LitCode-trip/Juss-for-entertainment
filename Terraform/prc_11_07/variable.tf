variable "aws-stg-env" {
  description = "contains staggin env"
  type = map(string({
    region = string
    instance_type = string
    ami = string
  }))
  default = {
    "stg-aps-1" = {
      region = "ap-south-1"
      instance_type = "t2.micro"
      ami = "asdsdasd"
  }
}
variable  "aws-prd-env" {
  description "prod env"
  type = map(string({
    region = strein

  })
  fr


}
var "stg-tagz " {

  type = map(string)
 default = {
   env = "stg"

 }
varable "sel_env" {
  type =  string

}

}


locals  {

  is_prod = can(var.aws-prd-env[var.sel_env])
  get_env = local.is_prod ? var.aws-prd-env : var.aws-stg-env
  set_env = local.get_env[var.sel_env]
  merge_tags = merge(local.set-tags, 
    {
       "Name" :  "terraform"


}
