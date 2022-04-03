# stella_stays

A Flutter calendar project with GraphQl dart backend. 

## Getting Started
This project consist both the Front end and server sode code. 

The server side code is present inside the server folder and using GraphQL to fetch the data (Unavailable Days and LOS) present in path server/lib/data.dart

`final data = {
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
`


