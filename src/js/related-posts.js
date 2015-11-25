var _     = require('lodash');
var React = require('react');
var request = require('superagent');

class RelatedPosts extends React.Component {
  constructor(props) {
    super(props);
    this.state = {items: []};
  }

  componentDidMount() {
    Promise.all(this.props.categories.map(category => this.getJSON(category)))
           .then(results => {
             var all_posts = _.reduce(results, (posts, result) => posts.concat(result.body), []);
             var sorted = _.sortBy(all_posts, post => Date.parse(post.date)).reverse();
             this.setState({items: sorted});
           })
           .catch(err => console.error(err));
  }

  render() {
    return (
      <div className="related-posts">
        <div className="header">このカテゴリーの他の記事</div>
        <RelatedPostsList items={this.state.items} />
      </div> 
    );
  }

  getJSON(category) {
    return new Promise((resolve, reject) => {
      request.get(`/categories/${category}/index.json`, (err, res) => {
        if (err) {
          reject(err);
          return;
        }

        resolve(res);
      });
    });
  }
}

class RelatedPostsList extends React.Component {
  render() {
    // IE have not first slash 'location.pathname'
    var current_path = location.pathname.indexOf('/') == 0 ?
                                  location.pathname : `/${location.pathname}`;
    var items = _(this.props.items).reject(item => item.url == current_path)
                                   .take(5).value();

    return (
      <div className="list">
        {items.map(item => <RelatedPostsItem key={item.id} data={item} />)}
      </div>
    );
  }
}

class RelatedPostsItem extends React.Component {
  render() {
    return (
      <a href={this.props.data.url} className="item">{this.props.data.title}</a>
    );
  }
}

module.exports = RelatedPosts;
