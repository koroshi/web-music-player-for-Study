//var itemviews ={}
//itemviews[id] = new item();
//this.itemview['id']




TestModel = Backbone.Model.extend({
    default:{
        name:'default',
        alert:'今天'
    }
});

TestCollection = Backbone.Collection.extend({
    model:TestModel
});

var testCollection = new TestCollection;

TestAppView = Backbone.View.extend({
    el:'body',
    events:{
        'contextmenu  #my':'test'
    },
    initialize:function(){
//        this.$el.con
        var modela = new TestModel({id:1})
        var modelb = new TestModel({id:2,alert:'明天'});
        var modelc = new TestModel({id:3,alert:'后天'});
        testCollection.add(modela);
        testCollection.add(modelb);
        testCollection.add(modelc);
//        alert('t');
        this.testItemView = {};
        var that = this;
        testCollection.each(function(value,key,list){
            console.log(value)
            console.log(key)
            console.log(value === modela)
            that.testItemView[value.id] = new TestItemView({model:value})
        });
    },
    test:function(event){
//        window.document.oncontextmenu = function(){ return false;}
        console.log(event.target)
        console.log($(event.target).data('start'))
        window.location.href = '#'+event.target.id
//        alert(event)
//        alert(a)
//        alert(c)
//        alert(test)
    }
});

TestItemView = Backbone.View.extend({
    initialize:function(){
//        alert('初始化itemview')
    },
    alert:function(){
        alert(this.model.toJSON().alert)
    }
});
var testAppView = new TestAppView;
//testAppView.testItemView[3].alert();