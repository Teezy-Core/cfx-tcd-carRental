
![Logo](https://media.discordapp.net/attachments/1020000303078199326/1114342182321655849/Teezy_Core_with_text.png)


![Script Screenshot](https://media.discordapp.net/attachments/1018054474926915676/1114372602903920650/Advanced_Car_Rental.png?width=1246&height=701)

![Visitors](https://api.visitorbadge.io/api/visitors?path=https%3A%2F%2Fgithub.com%2FTeezy-Core%2Fteezy-Carrental&label=Visitors&countColor=%23263759) 

[DONATE HERE](https://www.buymeacoffee.com/teezycore)
# Teezy Car Rental QBCore



A **Advanced** Car Rental for QBCore (Nopixel Inspired) Originally Made by [NaorNC](https://github.com/NaorNC). and enhanced by **Teezy Core**.
## Installation

1. Download the script from the source.
2. Place the script in the `resources` folder of your FiveM server.
3. Add the following line to your server.cfg file: `cfx-tcd-carRental`
4. Start your FiveM server and enjoy!

## Dependencies

- `qb-target`
- `qb-core`
- `qb-menu`
- `qb-input`
- optional: *menu used in the video* [jixel-menu](https://github.com/jimathy/jixel-menu)
- optional: [nh-context](https://github.com/whooith/nh-context)


## Item Setup

Put this on `qb-core > shared > items.lua`
```
["rentalpapers"]				 = {["name"] = "rentalpapers", 					["label"] = "Rental Papers", 			["weight"] = 50, 		["type"] = "item", 		["image"] = "rentalpapers.png", 		["unique"] = true, 		["useable"] = false, 	["shouldClose"] = false, 	["combinable"] = nil, 	["description"] = "This car was taken out through car rental."},
```

Download the Item `Image` here:
[rentalpapers.png](https://camo.githubusercontent.com/f4d5ba69f4e562213d609e8c53721e74f7703096f2d20869b6585cd89e9673a8/68747470733a2f2f692e6962622e636f2f73674735486b362f72656e74616c7061706572732e706e67)

![Item](https://camo.githubusercontent.com/f4d5ba69f4e562213d609e8c53721e74f7703096f2d20869b6585cd89e9673a8/68747470733a2f2f692e6962622e636f2f73674735486b362f72656e74616c7061706572732e706e67)

Put it inside your `qb-inventory > html > images` same if you are using `lj-inventory`

## Inventory JavaScript Setup

Inside your `qb-inventory > js > app.js`

**NOTE:** Go between Line 500-600 and add the following code

```
          } else if (itemData.name == "rentalpapers") {
            $(".item-info-title").html('<p>' + itemData.label + '</p>')
            $(".item-info-description").html('<p><strong>Plate: </strong><span>'+ itemData.info.label + '</span></p>');
```
If you did follow this correct you will see the `info` on the `rentalpapers` item

![SS](https://media.discordapp.net/attachments/1018054474926915676/1114360823972888668/image.png)

**That's all for the Installations.**
## Previews

[Preview 1](https://streamable.com/6cc80x)
[Preview 2](https://streamable.com/il9l1n)
[Preview 3](https://streamable.com/p50vks)
[Preview 4](https://streamable.com/fys36g)


## Features
- `Debug Mode` Some print thingy for debugging purposes and for `Debug Poly`
- `Enable/Disable Blips for Rentals`
- `Setup menu:` currently supported menus `(qb-menu, nh-context)`
- `Rental Plate Mark` a mark on a Vehicle plate which will be the indicator of the vehicle was only for rented.
- `Unlimited Vehicle to rent` just follow the instructions inside the `config.lua`
- `Configurable Rental Time` just follow the instructions inside the `config.lua`
- `Configurable Locations for Rent` just follow the instructions inside the `config.lua`
- `Custom Ped, and Scene for Each Rental Stations` just follow the instructions inside the `config.lua`
- `Configurable Vehicle Spawn` just follow the instructions inside 
- `Vehicle Nearby Detection` wither there is an vehicle near the spawn point of the vehicle it will notice the player
- `Automatic Vehicle Deletion upon the Rental Time` Vehicle will be Automatically deleted if Rental Time was already done.

## TODOS

- [ ] Add more menus support
- [ ] might be supported with ESX in the future
- [ ] Add Discord Logs
- [ ] Add more info on the `rentalpapers` item
## License

```
MIT License

Copyright (c) 2023 Lester

Permission is hereby granted, free of charge, to any person obtaining a copy
of this software and associated documentation files (the "Software"), to deal
in the Software without restriction, including without limitation the rights
to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
copies of the Software, and to permit persons to whom the Software is
furnished to do so, subject to the following conditions:

The above copyright notice and this permission notice shall be included in all
copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
SOFTWARE.
```
## Feedback

If you have any feedback, please reach out to me through discord `Ternology#6508`

