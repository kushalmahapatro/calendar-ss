# stella_stays

A Flutter calendar project with GraphQl dart backend. 

## Getting Started
This project consist both the Front end and server sode code. 

The server side code is present inside the server folder and using GraphQL to fetch the data (Unavailable Days and LOS) present in path server/lib/data.dart

``final data = {
  "unavailable_days": [
    '2022-04-04',
    '2022-04-05',
    '2022-04-06',
    '2022-04-10',
    '2022-04-24',
    '2022-04-28',
    '2022-05-01',
    '2022-05-06',
    '2022-05-15',
    '2022-05-22'
  ],
  "los": [
    {'day': '2022-04-02', 'los': '2'},
    {'day': '2022-04-03', 'los': '3'},
    {'day': '2022-04-07', 'los': '2'},
    {'day': '2022-04-11', 'los': '10'},
    {'day': '2022-04-12', 'los': '10'},
    {'day': '2022-04-25', 'los': '2'},
    {'day': '2022-04-29', 'los': '1'},
    {'day': '2022-05-04', 'los': '3'},
    {'day': '2022-05-06', 'los': '1'},
    {'day': '2022-05-12', 'los': '4'},
    {'day': '2022-05-30', 'los': '5'},
  ]
};
``
You can use the below configuration to run app and server in VSCode:
`"configurations": [
        {
            "name": "app",
            "request": "launch",
            "program": "lib/main.dart",
            "type": "dart"
        },
        {
            "name": "server",
            "cwd": "server",
            "request": "launch",
            "program": "server.dart",
            "type": "dart"
        }
    ]`

The server will run on http://127.0.0.1:3000 and the GraphiQL can be accessed from http://127.0.0.1:3000/graphiql

GraphQL query to get data
`query {
	unavailable_days {
		days
	}
	los_days {
		los_day {
			day
			los
		}
	}
}`

![GraphiQL UI](https://github.com/kushalmahapatro/calendar-ss/blob/main/images/Screen%20Shot%202022-04-03%20at%206.48.14%20PM.png "GraphiQL UI")

![Screenshot 1](https://github.com/kushalmahapatro/calendar-ss/blob/main/images/Simulator%20Screen%20Shot%20-%20iPhone%2013%20-%202022-04-03%20at%2015.51.18.png "Screenshot 1")

![Screenshot 2](https://github.com/kushalmahapatro/calendar-ss/blob/main/images/Simulator%20Screen%20Shot%20-%20iPhone%2013%20-%202022-04-03%20at%2016.02.40.png "Screenshot 2")

![Screenshot 3](https://github.com/kushalmahapatro/calendar-ss/blob/main/images/Simulator%20Screen%20Shot%20-%20iPhone%2013%20-%202022-04-03%20at%2018.46.08.png "Screenshot 3")

![Screenshot 4](https://github.com/kushalmahapatro/calendar-ss/blob/main/images/Simulator%20Screen%20Shot%20-%20iPhone%2013%20-%202022-04-03%20at%2018.46.13.png "Screenshot 4")

![Screenshot 5](https://github.com/kushalmahapatro/calendar-ss/blob/main/images/Simulator%20Screen%20Shot%20-%20iPhone%2013%20-%202022-04-03%20at%2018.46.23.png "Screenshot 5")

![Screenshot 6](https://github.com/kushalmahapatro/calendar-ss/blob/main/images/Simulator%20Screen%20Shot%20-%20iPhone%2013%20-%202022-04-03%20at%2018.46.29.png "Screenshot 6")

![Screenshot 7](https://github.com/kushalmahapatro/calendar-ss/blob/main/images/Simulator%20Screen%20Shot%20-%20iPhone%2013%20-%202022-04-03%20at%2018.46.39.png "Screenshot 7")

![Screenshot 8](https://github.com/kushalmahapatro/calendar-ss/blob/main/images/Simulator%20Screen%20Shot%20-%20iPhone%2013%20-%202022-04-03%20at%2018.47.00.png "Screenshot 8")

![Screenshot 8](https://github.com/kushalmahapatro/calendar-ss/blob/main/images/Screen%20Shot%202022-04-03%20at%206.59.51%20PM.png "Screenshot 8")




