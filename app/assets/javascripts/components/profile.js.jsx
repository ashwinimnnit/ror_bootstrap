var Profile = React.createClass({
 
  propTypes: {
    firstname: React.PropTypes.string,
    lastname: React.PropTypes.string
  },

  render: function() {
    return (
      <div>
        <div>Firstname: {this.props.firstname} </div>
        <div>Lastname: {this.props.lastname}</div>
      </div>
    );
  }
});
