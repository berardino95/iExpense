# iExpense
An expense tracker that separates personal costs from business costs.

In this app you can track your expenses, you can add it in the app inserting a Name, a type and the cost value. If needed you can modify your expense by clicking on the list row you want  edit. All the data are saved in UserDefaults every time a change of data is maded with didSet. When the app starts, inside the struct init, I retrive the data from UserDefaults and show them in the app.

Used: UserDefaults, didSet, init(), JSONEncoder, JSONDecoder, NavigationView, NavigationLink, Toolbar button, .sheet, 

![Simulator Screen Recording - iPhone 14 - 2023-05-09 at 22 18 41](https://github.com/berardino95/iExpense/assets/26569311/c65f9983-d322-43c8-b3f5-7717ccd2c783)
