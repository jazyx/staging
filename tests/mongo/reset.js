db.user.update({},{
  $set:{logged_in:[],history:{}}
, $unset:{loggedIn:0}
},{multi:true})
db.teacher.update({id:{$in:["jn","aa","ml"]}},{
  $set:{logged_in:[]}
, $unset:{loggedIn:0}
 },{multi:true})
db.group.update({},{
  $set:{logged_in:[],active:false}
, $unset:{
    loggedIn:0
  , view_size:0
  , viewSize:0
  , viewData:0
  , view_data:0
  , page:0
  , soloPilot: 0
  }
},{multi:true})
