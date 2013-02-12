Introduciton
------------------------

Bo-LuaWaxProjectTemplate is a xcode project template and tools for iOS development with Lua Wax

Installation
------------------------
You need to have [**waxsim**](https://github.com/square/waxsim) and [**Lua**](http://lua.org) installed before using this template

unzip the downloaded zip file to any where you like

Usage
------------------------
In terminal, change your directory to this project root
`````sh
cd <Bo-LuaWaxProjectTemplate root>
`````
### Create a project
`````sh
./createprj.sh <path of your project>
`````

### Run the newly created project
- you can open the project in xcode to build and run it as a normal xcode iOS app project

or 

- you can change your directory to the newly create project, and run **./build.sh**

`````sh
cd <path of the newly created project>
./build.sh
`````

the iOS simulator will automatically started

### where to put your lua code
you need to put your lua code under the *scripts* directory 