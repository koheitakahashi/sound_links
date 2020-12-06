const { environment } = require('@rails/webpacker')
const typescript =  require('./loaders/typescript')
const { VueLoaderPlugin } = require('vue-loader')
const { DefinePlugin } = require('webpack')

environment.loaders.prepend('typescript', typescript)
module.exports = environment

environment.plugins.prepend(
    'VueLoaderPlugin',
    new VueLoaderPlugin()
)

environment.loaders.prepend('vue', {
    test: /\.vue$/,
    use: [{
        loader: 'vue-loader'
    }]
})

environment.plugins.prepend(
    'Define',
    new DefinePlugin({
        __VUE_OPTIONS_API__: false,
        // or __VUE_OPTIONS_API__: true,
        __VUE_PROD_DEVTOOLS__: false
    })
)
