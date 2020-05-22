locals{

naming_convention_info = {
              name            = "eg"
              project_code    = "irasgcc" 
              env             = "dev" 
              zone            = "z1"
              agency_code     = "iras"
              tier            = "web"          
  }
} 

module "resource_groups" {
    source = "../"
    resource_groups = {
       1 =  {
            name = "test"
            location = "southeastasia"
            naming_convention_info= local.naming_convention_info
            tags = {
                
            }
        }
         2 =  {
            name = "test"
            location = "southeastasia"
            naming_convention_info= local.naming_convention_info
            tags = {
                
            }
        }
    }
}