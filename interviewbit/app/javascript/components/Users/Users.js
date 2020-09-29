import  React, { useState , useEffect , Fragment } from 'react'
//import { Route,Switch } from 'react-router-dom'
import axios from 'axios'
import User from './User'
const Users = () => {
	const [users, setUsers] =useState([])
	useEffect(()=>{
		// Get all users from api
		// Update users in state
		axios.get('/api/v1/users.json')
		.then( resp =>{
			setUsers(resp.data.data)
		})
		.catch(resp=> console.log(resp))
	},
	[users.length]
	)

	const list= users.map( item => {
		return (
			<User  
				attributes = {item.attributes}
			/>
		)
	})
	return (
		<Fragment>
		<div> This is users controller </div>
		<div className="container table table-stripped">
		<div>{list}</div>
		</div>
		</Fragment>
	)
}
export default Users