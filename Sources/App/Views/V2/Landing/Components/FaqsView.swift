//
//  FaqsView.swift
//  trip-planner
//
//  Created by Asiel Cabrera Gonzalez on 10/8/24.
//

import HTMLKit

struct FaqsView: View {
    let faqsLeft: [String] = ["How this theme is different from others in market?", "Is it possible to get a discount?", "How do I use this?"]
    let faqsRight: [String] = ["What other themes do you have?", "How can I contribute to Devjoy?", "What is your policy on distribution of Devjoy assets?"]
    var body: Content {
        Section {
            Div {
                Div {
                    H2 {
                        "Asked Questions"
                    }
                    .class("mx-auto text-center font-bold text-black text-3xl lg:text-5xl")
                    
                    Paragraph {
                        "Lorem ipsum dolor sit amet, consectetur adipiscing elit ut aliquam, purus sit amet luctus venenatis, lectus magna fringilla urna"
                    }
                    .class("font-inter mt-4 max-w-xl px-5 text-center text-base font-light text-gray-500 lg:max-w-lg")
                }
                .class("mx-auto flex max-w-xl flex-col items-center justify-center px-6 text-center lg:max-w-3xl lg:px-10")
                
                Div {
                    faqContainer(faqs: faqsLeft)
                    faqContainer(faqs: faqsRight)
                    
                }
                .class("mt-10 flex flex-col justify-between lg:flex-row lg:flex-wrap")
                
                Paragraph {
                    "Can’t find the answer you’re looking for? Reach out to our"
                    A {
                        "customer support team."
                    }
                    .class("text-black font-bold")
                }
                .class("font-inter mx-auto mt-12 text-center text-base text-gray-500")
            }
            .class("mx-auto w-full max-w-7xl px-5 py-16 md:px-10 md:py-20")
        }
        .id("faqs")
    }
    
    
    private func faqContainer(faqs: [String]) -> Content {
        return Div {
            for faq in faqs {
                self.faqBlock(faq)
            }
        }
        .class("mx-4 flex max-w-3xl flex-col lg:shrink lg:grow lg:basis-96")
    }
    
    private func faqBlock(_ faq: String) -> Content {
        Div {
            H2 {
                "\(faq)"
            }
            .class("font-bold text-black text-xl")
            
            Paragraph {
                "Lorem ipsum dolor sit amet, consectetur adipiscing elit ut aliquam, purus sit amet luctus venenatis, lectus magna fringilla urna"
            }
            .class("font-inter mt-4 text-base font-light text-gray-500")
            
            A {
                Svg {
                    Circle { }
                    .custom(key: "cx", value: 12)
                    .custom(key: "cy", value: 12)
                    .fill("white")
                    
                    Path {}
                        .draw("M7.04688 11.9999H16.9469")
                        .stroke("black")
                        .strokeWidth(2)
                        .strokeLineCap(.round)
                        .strokeLineJoin(.round)
                }
                .width(24)
                .height(24)
                .viewBox("0 0 24 24")
                .fill("none")
                .namespace("http://www.w3.org/2000/svg")
            }
                .class("absolute right-5 top-9")
                .reference("#")
        }
        .class("relative my-3 w-full rounded-md border border-gray-300 px-12 py-8")
    }
}
