class UpdateStatus (){

UpdateStatus(context) {
  return showDialog(
      context: context,
      builder: (BuildContext context) {
        return Expanded(
            child: AlertDialog(
              title: Text('Change Status!'),
              content: [
                ListTile(
                  title: Text('Idle'),
                  onTap: () {
                  },
                ),
                Divider(
                  height: 0,
                ),
                ListTile(
                  title: Text('In Progress'),
                  onTap: () {

                  },
                ),
                Divider(
                  height: 0,
                ),
                ListTile(
                  title: Text('Done'),
                  onTap: () {


                  },
                ),
              ],



            ));
      });



} //Alart dialog end here================


}