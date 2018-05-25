class FlashMessages extends React.Component {
  constructor(props) {
    super(props);

    this.state = { messages: props.messages };

    this.handleRemoveMessageClicked = this.handleRemoveMessageClicked.bind(this);
  }

  get messages() {
    return this.state.messages;
  }

  handleRemoveMessageClicked(event) {
    const removeLevel = event.target.parentElement.getAttribute('data-level');
    const updatedMessages = { ...this.state.messages };
    delete updatedMessages[removeLevel];

    this.setState({ messages: updatedMessages });
  }

  renderMessage(level, message) {
    if(message === undefined) {
      return null;
    }

    return (
      <div className={`alert alert-${level}`} data-level={level} key={level}>
        <span>{message}</span>
        <i onClick={this.handleRemoveMessageClicked}>{'\u2A2F'}</i>
      </div>
    );
  }

  render() {
    return (
      <div className="flash-messages">
        <div className="container">
          <div className="row">
            <div className="col-12">
              {Object.keys(this.messages).map(k => this.renderMessage(k, this.messages[k]))}
            </div>
          </div>
        </div>
      </div>
    );
  }
}

FlashMessages.propTypes = {
  messages: PropTypes.objectOf(PropTypes.string).isRequired,
};
