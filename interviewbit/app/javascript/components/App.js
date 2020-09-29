import React from 'react'
import { Route,Switch } from 'react-router-dom'
import User from './User/User'
import Users from './Users/Users'
const App = () => {
	return (
		<Switch>
		<Route exact path="/" component={Users} />,
		<Route exact path="/users/:id" component={User} />,
		</Switch>	
	)
}
export default App