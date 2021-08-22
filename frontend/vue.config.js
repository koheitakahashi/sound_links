module.exports = {
  devServer:{
    allowedHosts: [
      'sound-links.com',
      'sound-links-elb-frontend-' + process.env["AWS_ECS_ID"] + '.ap-northeast-1.elb.amazonaws.com'
    ]
  }
};
