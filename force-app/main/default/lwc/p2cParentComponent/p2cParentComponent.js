import { LightningElement } from 'lwc';

export default class P2cParentComponent extends LightningElement {
    val=10
    carouselData = [
        {
            src : "https://www.lightningdesignsystem.com/assets/images/carousel/carousel-01.jpg",
            header : "First Card",
            description : "First card description"
        },
        {
            src : "https://www.lightningdesignsystem.com/assets/images/carousel/carousel-02.jpg",
            header : "Second Card",
            description : "Second card description"
        },
        {
            src : "https://www.lightningdesignsystem.com/assets/images/carousel/carousel-03.jpg",
            header : "Third Card",
            description : "Third card description"
        },
    ]

    handleInputChange(event){
        this.val = event.target.value
    }

    handleClick(){
        const resetSlider = this.template.querySelector('c-p2c-slider-component').resetSlider()
    }
}