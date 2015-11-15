# Beaver

> Manage Pxe provisionings trough a REST api.

## General

Create first user / reset admin password:

`rake setup:credentials`

GET /
> Returns non relevant information.

`curl -H "Accept: application/json" http://beaver.example.com`

GET /help
> List available API entrypoints.

## Users

GET /users
> List all users.

`curl -H "Accept: application/json" -X GET http://user:password@beaver.example.com/users`

POST /users
> Create a user.

> Parameters:

> * login (required)
> * password (required)

`curl -H "Accept: application/json" -X POST -d '{"login":"newuser","password":"supersecret"}' http://user:password@beaver.example.com/users`

PATCH /users/:id
> Edit a user.

> Parameters:

> * id (required)
> * login
> * password

`curl -H "Accept: application/json" -X PATCH -d '{"password":"supersecret"}' http://user:password@beaver.example.com/users/1`

DELETE /users/:id
> Delete a user.

> Parameters:

> * id (required)

`curl -H "Accept: application/json" -X DELETE http://user:password@beaver.example.com/users/1`

## Templates

GET /templates
> Lists templates.

`curl -H "Accept: application/json" -X GET http://user:password@beaver.example.com/templates`

GET /templates/:id
> Get template details.
`curl -H "Accept: application/json" -X GET http://user:password@beaver.example.com/templates/1`

POST /templates
> Create a template.

> Parameters:

> * name(required)
> * template_types_id(required)
> * file(required)

`curl -i -X POST -H "Content-Type: multipart/form-data" -F "name=my first kickstart" -F "template_types_id=2" -F "file=@anaconda-ks.cfg" http://user:password@beaver.example.com/templates`


PATCH /templates/:id

> Edit a template.

> Parameters:

> * name
> * template_types_id
> * file

`curl -i -X PATCH -H "Content-Type: multipart/form-data" -F "name=my first kickstart v1"  http://user:password@beaver.example.com/templates/1`

DELETE /templates/:id

> Delete a template.

> Parameters:

>* id(required)

`curl -H "Accept: application/json" -X DELETE http://user:password@beaver.example.com/templates/1`

## Template Types

GET /templatetyes

> List template types.

`curl -H "Accept: application/json" -X GET http://user:password@beaver.example.com/templatetypes`

## Operating Systems

GET /operatingsystems

> List Operating Systems

`curl -H "Accept: application/json" -X GET http://user:password@beaver.example.com/operatingsystems`

GET /operatingsystems/:id

> Get Operating System details.

> Parameter:

>* id(required)

`curl -H "Accept: application/json" -X GET http://user:password@beaver.example.com/operatingsystems/1`

POST /operatingsystems

> Create a Operating System

> Parameters:

>* name(required)
>* major(required)
>* minor(required)
>* url (required)

`curl -H "Accept: application/json" -X POST -d '{"name":"Centos","major":6,"minor":7,"url":"http://mirror.centos.org/pub/centos/6.7/os/x86_64/"}' http://user:password@beaver.example.com/operatingsystems`

PATCH /operatingsystems/:id

> Update a Operating System

>*id(required)
>* name
>* major
>* minor
>* url

`curl -H "Accept: application/json" -X PATCH -d '{"name":"Centos custom"}' http://user:password@beaver.example.com/operatingsystems/1`

DELETE /operatingsystems/:id

> Delete a Operating System

> Parameter:

>* id(required)

`curl -H "Accept: application/json" -X DELETE http://user:password@beaver.example.com/operatingsystems/1`

## Host Configs

GET /hostconfigs

> List host configs.

`curl -H "Accept: application/json" -X GET http://user:password@beaver.example.com/hostconfigs`

GET /hostconfigs/:id

> Get host config details.

> Parameter:

>* id(required)

`curl -H "Accept: application/json" -X GET http://user:password@beaver.example.com/hostconfigs/1`

POST /hostconfigs

> Create a host config.

> Parameters:

>* name(required)
>* settings(required)

`curl -H "Accept: application/json" -X POST -d '{"name":"myHostconfig","settings":{"hostname":"myhostname","rootpassword":"supersecret","network":{"interface":{"eth0":{"ip":"192.168.0.200","netmask":"24"}}}} }'  http://user:password@beaver.example.com/hostconfigs`

PATCH /hostconfigs/:id

> Update a host config.

> Parameters:

>* id(required)
>* name
>* settings

`curl -H "Accept: application/json" -X PATCH -d '{"settings":{"hostname":"myhostname","rootpassword":"megasupersecret","network":{"interface":{"eth0":{"ip":"192.168.0.30","netmask":"24"}}}} }' http://user:password@beaver.example.com/hostconfigs/1`

DELETE /hostconfigs/:id

> Delete a host config.

> Parameter:

>* id(required)

`curl -H "Accept: application/json" -X DELETE http://user:password@beaver.example.com/hostconfigs/1`

## Provisions

POST /provisions

> Create a provision.

> Parameters:

>* host(required)
>* operating_systems_id(required)
>* templates_id(required)
>* host_configs_id
>* host_attributes

`curl -k -H "Accept: application/json" -X POST -d '{"host":"52:54:00:c4:96:5e","operating_systems_id":1,"templates_id":14,"host_configs_id":1,"host_attributes":{"rootpassword":"megasecret"}}' http://user:password@beaver.example.com/provisions`
