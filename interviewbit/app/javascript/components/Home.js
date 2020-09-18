import React , {Component} from 'react'
import Jumbotron from './Jumbotron'
class Home extends Component {
	/*super()
	constructor(){
		this.state={
			modules:[
				{ id:1, title:'ABCD', description: ' ', active:false  },
				{ id:2, title:'KJLM', description: ' ', active:false  },
				{ id:3, title:'PQRS', description: ' ', active:false  },
				{ id:4, title:'WXYZ', description: ' ', active:false  },
			]
		}
	}*/
	render(){
		return(
			<div> Hello World, This is a react application 
			
			<Jumbotron/>
			</div>
			
		)
	}
}

export default Home