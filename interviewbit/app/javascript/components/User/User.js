import React , {useState,useEffect} from 'react'
import { Route,Switch,Link } from 'react-router-dom'
import axios from 'axios'
import UserCard from './UserCard'
import NewForm from './NewForm'
const User= (props) => {
	const [ user , setUser ] = useState({})
	const [interviews, setInterviews] = useState({})
	const [loaded, setLoaded] = useState(false)
	useEffect(()=>{

		const u_id = props.match.params.id;
		const url = `/api/v1/users/${u_id}`;
		axios.get(url)
		.then( resp => {
			setUser(resp.data.data)
			setLoaded(true)
		})
		.catch(resp => console.log(resp));
	},
	[]
	)
	return (
		<div className="container">
	{	loaded && 
		<UserCard
			attributes={user.attributes}
		/>
	}
	<h4><Link className="btn btn-success" to={`/`}>Home</Link></h4>	
		</div>	
	)
}
export default User