Introduciton
------------------------

Bo-LuaWaxProjectTemplate is a xcode project template and tools for iOS development with Lua Wax

Installation
------------------------
You need to have [**waxsim**](https://github.com/square/waxsim) and [**Lua**](http://lua.org) installed before using this template

unzip the downloaded zip file to any where you like

Usage
------------------------
First you need to compile two version of **Lua**: one for the usage in mac os x, another one for working on iphone
`````sh
cd <Bo-LuaWaxProjectTemplate root>
./buildlua.sh
`````

### Create a project
In terminal, change your directory to this project root
`````sh
cd <Bo-LuaWaxProjectTemplate root>
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

### how to compile lua code to byte code during the build
by default, wax will copy all your lua source code to the application. To use the byte code in the application,
you need to open the project in xcode and modify the user setting WAX_COMPILE_SCRIPTS from **false** to **true**


### TODO
- LuaJIT support
