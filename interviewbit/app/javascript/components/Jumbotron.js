import React , {Component} from 'react'

class Jumbotron extends Component{
	render(){
		return(
			<div className="container container-fluid">
				<button className="btn btn-success" > Schedule New Interview</button> 
				<button className="btn btn-warning" > View All Users</button> 
				<button className="btn btn-success" > Create New User</button> 
				<button className="btn btn-warning" > View All Interview</button>
			</div>
		)
	}
} 
export default Jumbotron