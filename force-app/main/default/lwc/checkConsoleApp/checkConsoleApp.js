import { LightningElement, wire } from 'lwc';
import {IsConsoleNavigation} from 'lightning/platformWorkspaceApi';

export default class CheckConsoleApp extends LightningElement {
    @wire(IsConsoleNavigation)
    isConsoleNavigation
}