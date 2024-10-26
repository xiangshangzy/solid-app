import Consul from "consul";


export const ConfigConsul = async() => {
    const consul = new Consul()
    const members=await consul.agent.members()
    console.log(members)
}