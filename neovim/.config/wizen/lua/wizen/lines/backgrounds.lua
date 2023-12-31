local Lines = require("wizen.lines")

local backgrounds = {}

backgrounds.aurora = Lines:new([[
    ` : | | |:  ||  :     `  :  |  |+|: | : : :|   .        `              .
      ` : | :|  ||  |:  :    `  |  | :| : | : |:   |  .                    :
         .' ':  ||  |:  |  '       ` || | : | |: : |   .  `           .   :.
                `'  ||  |  ' |   *    ` : | | :| |*|  :   :               :|
        *    *       `  |  : :  |  .      ` ' :| | :| . : :         *   :.||
             .`            | |  |  : .:|       ` | || | : |: |          | ||
      '          .         + `  |  :  .: .         '| | : :| :    .   |:| ||
         .                 .    ` *|  || :       `    | | :| | :      |:| |
 .                .          .        || |.: *          | || : :     :|||
        .            .   . *    .   .  ` |||.  +        + '| |||  .  ||`
     .             *              .     +:`|!             . ||||  :.||`
 +                      .                ..!|*          . | :`||+ |||`
     .                         +      : |||`        .| :| | | |.| ||`     .
       *     +   '               +  :|| |`     :.+. || || | |:`|| `
                            .      .||` .    ..|| | |: '` `| | |`  +
  .       +++                      ||        !|!: `       :| |
              +         .      .    | .      `|||.:      .||    .      .   
          '                           `|.   .  `:|||   + ||'     `
  __    +      *                         `'       `'|.    `:
"'  `---"""----....____,..^---`^``----.,.___          `.    `.  .    ____,.
    ___,--'""`---"'   ^  ^ ^        ^       """'---,..___ __,..---""'
--"'                                 ^                         ``--..,__
]])

backgrounds.space2 = Lines:new([[
                    .                                            .
     *   .                  .              .        .   *          .
  .         .                     .       .           .      .        .
        o                             .                   .
         .              .                  .           .
          0     .
                 .          .                 ,                ,    ,
 .          \          .                         .
      .      \   ,
   .          o     .                 .                   .            .
     .         \                 ,             .                .
               #\##\#      .                              .        .
             #  #O##\###                .                        .
   .        #*#  #\##\###                       .                     ,
        .   ##*#  #\##\##               .                     .
      .      ##*#  #o##\#         .                             ,       .
          .     *#  #\#     .                    .             .          ,
                      \          .                         .
____^/\---^--__________O______________/\/\---/\___________---______________
   /\^   ^  ^    ^                  ^^ ^  '\ ^          ^       ---
         --           -            --  -      -         ---  __       ^
   --  __                      ___--  ^  ^                         --  __
]])

backgrounds.sunset = Lines:new([[
                                @@@@@@@@@
       ^^      ^^            @@@@@@@@@@@@@@@
          ^^               @@@@@@@@@@@@@@@@@@              ^^
                          @@@@@@@@@@@@@@@@@@@@
~~~~ ~~ ~~~~~ ~~~~~~~~ ~~ &&&&&&&&&&&&&&&&&&&& ~~~~~~~ ~~~~~~~~~~~ ~~~
~         ~~   ~  ~       ~~~~~~~~~~~~~~~~~~~~ ~       ~~     ~~ ~
  ~      ~~      ~~ ~~ ~~  ~~~~~~~~~~~~~ ~~~~  ~     ~~~    ~ ~~~  ~ ~~ 
  ~  ~~     ~         ~      ~~~~~~  ~~ ~~~       ~~ ~ ~~  ~~ ~ 
~  ~       ~ ~      ~           ~~ ~~~~~~  ~      ~~  ~             ~~
      ~             ~        ~      ~      ~~   ~             ~
]])

backgrounds.mountains = Lines:new([[
          _    .  ,   .           .
    *  / \_ *  / \_      _  *        *   /\'__        *
      /    \  /    \,   ((        .    _/  /  \  *'.
 .   /\/\  /\/ :' __ \_  `          _^/  ^/    `--.
    /    \/  \  _/  \-'\      *    /.' ^_   \_   .'\  *
  /\  .-   `. \/     \ /==~=-=~=-=-;.  _/ \ -. `_/   \
 /  `-.__ ^   / .-'.--\ =-=~_=-=~=^/  _ `--./ .-'  `-
/        `.  / /       `.~-^=-=~=^=.-'      '-._ `._
]])

backgrounds.space = Lines:new([[
                    .                                            .
     *   .                  .              .        .   *          .
  .         .                     .       .           .      .        .
        o                             .                   .
         .              .                  .           .
          0     .
                 .          .                 ,                ,    ,
 .                     .                         .
      .    .     ,
   .                .       -*-       .                   .            .
     .                           ,             .                .
           .               .                              .        .
                     .                  .                        .
   .                                            .                     ,
        .                               .                     .
      .           .               .                             ,       .
          .                 .                    .             .          ,
                                 .                         .
-------^----------------^-----------------------v--------------------------
     ^   ^  ^    ^                  ^^ ^  '\ ^          ^       ---
         --           -            --  -      -         ---  __       ^
   --  __                      ___--  ^  ^                         --  __
]])

backgrounds.stars = Lines:new([[
 .              +   .                .   . .     .  .
                   .                    .       .     *
  .       *               -*-       . . . .  .   .  + .
                     `                .   `  +  . . .
.          *                    .  .   .    .    . `
     +         .              .     .     . +.    +  .
                                .       .   . .
        . .           `      .    * . ` .  .  +   .
  -+-      +      .           .   .      +
                            .       . +  .+. .
  .                      .     . + .  . .     .      .
           .      .    .   ` . .   . . .        ! /
      *             .    . .  +    .  .       - O -
          .     .    .  +   ` .  *  .       . / |
               . + .  .  .  .. +  .
.      .  .  .  *   .  *  . +..  .            *
 .      .   . .   .   .   . .  +   .    .            +
  ]])

backgrounds.clouds1 = Lines:new([[
            _                                  
          (`  ).                   _           
         (     ).              .:(`  )`.       
        _(       '`.          :(   .    )      
    .=(`(      .   )     .--  `.  (    ) )      
   ((    (..__.:'-'   .+(   )   ` _`  ) )                 
   `(       ) )       (   .  )     (   )  ._   
     ` __.:'   )     (   (   ))     `-'.-(`  ) 
  ( )       --'       `- __.'         :(      )) 
 (_.'          .')                    `(    )  ))
              (_  )                     ` __.:'          
]])

backgrounds.clouds2 = Lines:new([[
      \       I     				
                  /
        \  ,g88R_
          d888(`  ).                   _
 -  --==  888(     ).=--           .+(`  )`.
)         Y8P(       '`.          :(   .    )
        .+(`(      .   )     .--  `.  (    ) )
       ((    (..__.:'-'   .=(   )   ` _`  ) )
`.     `(       ) )       (   .  )     (   )  ._
  )      ` __.:'   )     (   (   ))     `-'.:(`  )
)  )  ( )       --'       `- __.'         :(      ))
.-'  (_.'          .')                    `(    )  ))
                  (_  )                     ` __.:'
]])

return backgrounds
