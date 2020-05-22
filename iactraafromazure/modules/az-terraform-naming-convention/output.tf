#output the list(map) 
/*
/*
input - > naming_convention_info =  {
abc = {
  name_info = {}
  tags = {}
}
def = {
  name_info = {}
  tags = {}
}}

output ->  {
  abc = {
    names: string
    tags: {}
  },
  def = {
    names: string
    tags: {}
  }
}
*/
output "naming_convention_output" {
  description = "Outputs the list(map)"
  value = local.name_info_op
}