({
    onload : function(component) {
        var MyPageRef = component.get("v.pageReference")
        var id = MyPageRef.state.c__id
        component.set("v.id", id)

    }
})