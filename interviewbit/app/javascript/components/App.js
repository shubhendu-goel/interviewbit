import React from 'react'
import { Route,Switch } from 'react-router-dom'
import User from './User/User'
import NewForm from './User/NewForm'
import Home from './Home/Home'
const App = () => {
	return (
		<Switch>
		<Route exact path="/" component={Home} />,
		<Route exact path="/users/:id" component={User} />,
		<Route exact path="/users/new/" component={NewForm} />,
		</Switch>	
	)
}
export default App